module PetsHelper
    
    def get_str_key(key)
        i = key.to_i
        result = key
        if(i<10)
            return "000"+key.to_s
        elsif(i<100)
            return "00"+key.to_s
        elsif(i<1000)
            return "0"+key.to_s
        end
        
        return key.to_s
    end
end
