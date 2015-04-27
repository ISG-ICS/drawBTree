import json,fileinput,sys

id =0

def getNewId():
    global id
    id+=1
    return str(id)

def getField(i):
    return '<f' + str(i) + '>'

def printLabel(node, name):
    i = 0
    sys.stdout.write(name + '[label = "')        
    sys.stdout.write(getField(i))
    for key in node['keys']:
        i+=1
        sys.stdout.write('|' + str(key) + '|' + getField(i))
    sys.stdout.write('"];\n')

def printEdge(myName, i, child):
    sys.stdout.write('"' + myName + '":f' + str(i) + ' -> "' + child + '"\n' )

def printNode(node):
    myName = 'node' + getNewId();
    printLabel(node, myName)
    childrenNames = []
    if 'children' in node:
        for child in node['children']:
            childrenNames.append( printNode(child))
        i = 0
        for child in childrenNames:
            printEdge(myName, i, child)
            i+=1
    return myName


jsonfile = ''
for line in fileinput.input():
    jsonfile += line

btree = json.loads(jsonfile);

sys.stdout.write('digraph BTree { node [shape = record,height=.1];\n')
printNode(btree)
sys.stdout.write('}\n')

