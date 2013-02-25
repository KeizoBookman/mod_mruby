module ModMruby
  def ModMruby.escape(str)
    reserved_str = [
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "n", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "-", "_", ".", "~",
    ]
    tmp = ''
    str = str.to_s
    str.size.times do |idx|
      chr = str[idx]
      if reserved_str.include?(chr)
        tmp += chr
      end
    end
    tmp
  end
  class API
    def initialize
      @a = Apache
      @r = @a::Request.new
      @s = @a::Server.new
      @m = Discount.new("http://kevinburke.bitbucket.org/markdowncss/markdown.css", "mod_mruby test page")
    end
    def call
      param = @r.uri.split("/")
      
      el = {
        :id      => Random::rand(1000000),
        :key     => ModMruby.escape(param[1]),
        :type    => ModMruby.escape(param[2]),
        :class   => ModMruby.escape(param[3]),
        :method  => ModMruby.escape(param[4]),
        :val     => ModMruby.escape(param[5]),
      }

      @a.errlogger 4, "=== [#{el[:id]}] api request [#{el[:class]}:#{el[:method]}]==="
      el.each_key do |key|
        @a.errlogger 4, "#{key}: #{el[key]}"
      end
      @a.errlogger 4, "=== [#{el[:id]}] api request [#{el[:class]}:#{el[:method]}]==="

      call_api(el)
    end
    def call_api(param)
      if param[:class] == "request"
        ModMruby::API::Request.new(param).send(param[:method])
      else
        @a.return Apache::DECLINED
      end
    end
    class Request
      def initialize(param)
        @a = Apache
        @r = Apache::Request.new
        @s = Apache::Server.new
        @param = param
        @r.content_type = "application/json"
        @r.filename = "#{@s.document_root}/dummy"
        @r.status = 200
        @a.return Apache::OK
      end
      def uri; @a.rputs JSON::stringify(@param.merge({:result => {:uri => @r.uri}})); end
    end
  end
end

api = ModMruby::API.new
api.call
