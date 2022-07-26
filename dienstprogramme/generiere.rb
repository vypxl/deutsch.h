require 'yaml'
require 'fileutils'

class Header
    

    def initialize(name, clib = nil)
        if clib == nil
           from_yaml(name) 
           return
        end
        @name = name
        @clib = clib
        @renames = []
    end

    def from_yaml(yaml_content)
        obj = YAML.load yaml_content
        @name = obj["name"]
        @clib = obj["cbibliothek"]
        al = obj["umbenennungen"]
        @renames = []
        al.each do |key, val| 
            @renames << [key, val]
        end
    end

    def add_pair(german, englisch)
        @renames << [german, englisch]
    end

    

    def generate_file_content
        out = "#include <#{@clib}.h>\n"
        @renames.each do |rename|
            german, english = rename[0], rename[1]
            line = "#define #{german} #{english}\n"
            out += line
        end
        
        out
    end

    def to_yaml
        al = {}
        @renames.each do |rename|
            
            al[rename[0]] = rename[1]
        end
        obj = {
            "name" => @name,
            "cbibliothek" => @clib,
            "umbenennungen" => al
        }
        YAML.dump obj
    end

    def generate_file(path)
        FileUtils.rm_rf path
        FileUtils.mkdir path
        total_path = "#{path}/#{@name}.h"
        if File.exist? total_path
            File.delete total_path
        end
        File.write total_path, generate_file_content()
    end
end




def read_headers(path)
    entries = Dir.entries "."
    headers = []
    entries.each do |entry|
        extension = File.extname entry
        if extension == ".yaml" || extension == ".yml"
            file = File.open entry
            file_content = file.read
            header = Header.new file_content
            headers << header
        end
    end
    headers
end

def write_c_headers(headers, path)
    headers.each do |header|
        header.generate_file path
    end
end

definitions_path = ARGV[0].nil? ? "." : ARGV[0]
out_path = ARGV[1].nil? ? "deutsch" : ARGV[1]

headers = read_headers definitions_path
write_c_headers headers, out_path