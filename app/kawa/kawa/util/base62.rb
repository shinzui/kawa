module Kawa
  module Util
    module Base62
      extend self

      CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
      BASE = 62

      def encode(value)
        s = []
        while value >= BASE
          value, rem = value.divmod(BASE)
          s << CHARS[rem]
        end
        s << CHARS[value]
        s.reverse.join("")
      end

      def decode(str)
        str = str.split('').reverse
        total = 0
        str.each_with_index do |v,k|
          total += (CHARS.index(v) * (BASE ** k))
        end
        total
      end
    end
  end
end
