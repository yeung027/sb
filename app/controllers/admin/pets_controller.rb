require 'net/http'
require 'open-uri'
require 'rexml/document'

class Admin::PetsController < ApplicationController
    layout "backend"
    before_action :authenticate_user
    
    
    def index
        @max_number = 0
        @first = Pet.select("number").order("number desc").first
        if !@first.nil?
            @max_number = @first.number
        end
    end
    
    def form_search
        @pet = Pet.find_by_number(params[:number])
        
        @result = @pet.to_json(:only => [:number], :methods => [:get_profile_image])
        
        respond_to do |format|
            #format.html
            format.json { render :json => @result }
        end
    end
    
    
    def batch_upload
        
        
        
        #render :plain=>"kwan"
    end
    
    def refine_data
        connection = ActiveRecord::Base.connection
        connection.execute("update pets set type1 = replace(type1, 'タイプ', '')")
        connection.execute("update pets set type2 = replace(type2, 'タイプ', '')")
        connection.execute("update pets set type1 = replace(type1, '育成用モンスター', '育成用')")
        render :plain=> "finished"
    end
    
    
    def do_batch_upload
        
        @params = params.require(:xml).permit(:file)
        
        flash[:error]  = "This Function is disabled"
        redirect_to root_path
        return
        data = File.read("batch/"+@params[:file]+".xml")
        if !@params[:file]=="play"
            data    = data.gsub!(/&(?!(?:amp|lt|gt|quot|apos);)/, '&amp;')
        end
        doc = REXML::Document.new(data)
        
        span_index = 1
        top4div_index = 1
        dl_index    = 1
        material_span_index = 1
        skill_div_index = 1
        test = ""
        doc.elements.each('root/div') do |pet|

            name, key, attribute, type1, type2, ability1, ability2, ability3, leader_skill, active_skill, obtain =""
            before_evolution, after_evolution, material_1, material_2, material_3, material_4 = ""
            leader_skill_desc, skill_desc = ""
            
            pet.elements.each('span') do |span|
                
                if(span_index==2)
                    name =  span.attributes["data-search-value"]
                elsif(span_index==4)
                    key =  get_str_key(span.attributes["data-search-value"])
                elsif(span_index==5)
                    attribute =  span.attributes["data-search-value"]
                elsif(span_index==6)
                    type1 =  span.attributes["data-search-value"]
                elsif(span_index==7)
                    type2 =  span.attributes["data-search-value"]
                elsif(span_index==8)
                    abilitys    = span.attributes["data-search-value"]
                    abilitys    = abilitys.split(/\s*,\s*/)
                    ability1    = abilitys[0]
                    ability2    = abilitys[1]
                    ability3    = abilitys[2]
                elsif(span_index==9)
                    leader_skill =  span.attributes["data-search-value"]
                elsif(span_index==11)
                    active_skill =  span.attributes["data-search-value"]
                end#end span_index==2 id 
                span_index+=1   
            end#end span each
            span_index = 1
            #####
            
            
            pet.elements.each('div/div/div') do |top4div|
                if(top4div_index==3)
                    obtain = get_obtain(top4div)
                elsif(top4div_index==4)
                    before_evolution = get_background_image_key(top4div.to_s)
                end
                
                top4div_index+=1
            end#end top 4div each
            top4div_index = 1
            #####
            
            
            pet.elements.each('div/div/dl') do |dl|
                if(dl_index==1)
                    dl.elements.each('dt') do |dt|
                        after_evolution    = get_background_image_key(dt.to_s)
                    end#end dt
                    
                    dl.elements.each('dd/div/span') do |material_span|
                        if (material_span_index ==1)
                            material_1    = get_background_image_key(material_span.to_s)
                        elsif(material_span_index ==2)
                            material_2    = get_background_image_key(material_span.to_s)
                        elsif(material_span_index ==3)
                            material_3    = get_background_image_key(material_span.to_s)
                        elsif(material_span_index ==4)
                            material_4    = get_background_image_key(material_span.to_s)
                        end
                        material_span_index += 1
                    end#end material_span
                    material_span_index = 1
                elsif(dl_index==4)
                    dl.elements.each('dd/div') do |leader_div|        
                        leader_skill_desc    = leader_div.text
                    end
                elsif(dl_index==5)
                    dl.elements.each('dd/div') do |skill_div|        
                        if (skill_div_index ==1)
                            skill_desc = skill_div.text
                        end
                        skill_div_index+=1
                    end
                    skill_div_index=1
                end#dl_index_if
                
                dl_index+=1
            end#end dl each
            dl_index = 1
            test += get_site_map_xml_pet_part(key.to_i, name)
            
            #name, key, attribute, type1, type2, abilitys, leader_skill, active_skill, obtain =""
            #before_evolution, after_evolution, material_1, material_2, material_3, material_4 = ""
            #leader_skill_desc, skill_desc = ""
            
            
            pet = Pet.new
            pet.name        = name
            pet.number      = key.to_i
            pet.pet_attribute      = attribute
            pet.type1      = type1
            pet.type2      = type2
            pet.ability1      = ability1
            pet.ability2      = ability2
            pet.ability3      = ability3
            pet.leader_skill_name      = leader_skill
            pet.active_skill_name      = active_skill
            pet.obtain      = obtain
            pet.before_evolution      = before_evolution.to_i
            pet.after_evolution      = after_evolution.to_i
            pet.material_1      = material_1.to_i
            pet.material_2      = material_2.to_i
            pet.material_3      = material_3.to_i
            pet.material_4      = material_4.to_i
            pet.leader_skill      = leader_skill_desc
            pet.skill       = skill_desc
            
            pet = Pet.find_by_number(key.to_i)
            pet.has_default_image   = true
            pet.save!
            
            #download_image(key)
            
            
            
            
            
            
        end#end root/div each
        
        render :plain => "ok, test: "+ test.to_s
    end#end do_batch_upload
    
    private
    
    def get_site_map_xml_pet_part(key, name)
        str = "<url>"
        str += "<loc>http://sb-heyhei.rhcloud.com/pets/"+key.to_s+"</loc>"
        str += "<image:image>"
        str += "<image:loc>http://sb-heyhei.rhcloud.com/assets/pets/icon/"+get_str_key(key.to_s)+".png</image:loc>"
        str += "<image:caption>"+name+"</image:caption>"
        str += "</image:image>"
        str += "</url>"
        return str
    end#end of get_site_map_xml_pet_part
    
    
    def get_str_key(key)
        i = key.to_i
        result = key
        if(i<10)
            return "000"+key
        elsif(i<100)
            return "00"+key
        elsif(i<1000)
            return "0"+key
        end
        
        return key
    end
    
    def xml_params
        params.require(:xml).permit(:content)
    end
    
    def get_obtain(obj)
        result = ""
        count = 0
        obj.elements.each('span/a') do |a|
            result = result + (count==0 ? "" : "<br>") + a.text.to_s
            count+=1
        end
        
        if result != ""
            return result
        end
        
        count = 0
        obj.elements.each('span') do |span|
            result = result + (count==0 ? "" : "<br>") + span.text.to_s
            count+=1
        end
        if result != ""
            return result
        end
        return nil
    end
    
    
    
    
    def get_background_image_key(str)
        search  = "background-image:url(./images/icon_"
        index   = str.index(search)
        if(!index)
            return nil
        end
        search_len  = search.length
        
        result  = str[index+search_len, 4]
        
        return result
    end
    
    def download_image(key)
        url = "http://www.4gamer.net/games/246/G024675/FC20141222001/images/ss_"+key+".jpg"
        open('batch/images/big/'+key+'.png', 'wb') do |file|
            file << open(url).read
        end#end big
        
        url2 = "http://www.4gamer.net/games/246/G024675/FC20141222001/images/icon_"+key+".gif"
        open('batch/images/icon/'+key+'.png', 'wb') do |file|
            file << open(url2).read
        end#end big
        
        end#emddownload_image
    
end
