# DrawABTree
## Prerequisites
* You need to have the python2.7 and the [graphviz](http://www.graphviz.org/) to make the script work.
  * To install the graphviz on Linux machine: `sudo apt-get install graphviz`
* You need to provide a valid format of JSON file such as this:
```
{
"keys":["P"],
"children":[
    {"keys":["C","G","M"],
     "children": [
        {"keys": ["A:[(1,1),(1,2)]","B:[(2,1),(2,2)]"]},
        {"keys": ["D:[(3,1),(3,2)]","E:[(4,1)]","F:[(5,1)]"]},
        {"keys": ["J:[(5,1),(5,2)]","K:[(6,1),(6,2)]","L:[(7,1)]"]},
        {"keys": ["N:[(8,1)]","O:[(9,1)]"]}
    ]},
    {"keys":["T","X"],
     "children": [
        {"keys": ["Q:[(10,1)]","R:[(11,1)]","S:[(12,1)]"]},
        {"keys": ["U:[(13,1)]","V:[(14,1)]"]},
        {"keys": ["Y:[(15,1)]","Z:[(16,1)]"]}
    ]}
]
}

```
## Usage
Give a list of JSON file, it will generate the SVG format graph in the same path of the input file but with a ".svg" surfix.
```
./printBTree.sh tree.json 
```
It should output like this:
```
>  The graph of "tree.json" is output to "tree.json.svg"
```
The graph looks like ![this](/tree.json.png)

We suggest you use a browser to open that `.svg` file.

# Ref
This tool is inspired by this project: http://ysangkok.github.io/js-clrs-btree/btree.html
