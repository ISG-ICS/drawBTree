require 'sinatra'
require 'open3'
require 'tempfile'
require 'haml'

$form ="<p>Or paste yout json text here and click submit:" + 
    '<form action="/textinput"  method="POST" id="textform">' +
    '<input type="submit">' +
    '</form>' +
    '<textarea rows="30" cols="100" name="text" form="textform">' +
    '</textarea>'

$upload = "<p>Please upload another json file:" +
    "<a href='/upload'><button>click me</button></a>" 


get '/' do
    "<h1>Draw your BTree</h1>\n" +
        $upload + $form
end

get '/upload' do
    code = '%form{:action=>"/upload",:method=>"post"   ,:enctype=>"multipart/form-data"}'+ "\n" +
        '  %input{:type=>"file",:name=>"file"}' + "\n" +
        '    %input{:type=>"submit",:value=>"Upload"}'
    haml code
end

post '/textinput' do
    text = params['text']
    file = Tempfile.new('myjson')
    file.write(text)
    file.close
    STDERR.puts "input" + file.path
    output = file.path + '.svg'
    cmd = './data/printBTree.sh ' + file.path
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        exit_status = wait_thr.value
        unless exit_status.success?
            return '<p>error: ' + stderr.read 
        end
    end
    STDERR.puts "output:" + output

    File.open(output).read + $upload + $form

end

post '/upload' do
    if params['file']== nil
        return "<p> file not valid , please <a href='/upload'> upload again </a> "
    end

    realfile = params['file'][:tempfile].path
    cmd = './data/printBTree.sh ' + realfile
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        exit_status = wait_thr.value
        unless exit_status.success?
            return '<p>error: ' + stderr.read 
        end
    end

    File.open(realfile + '.svg').read + 
        $upload + $form
end
