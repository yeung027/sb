$( document ).ready(function() 
{
    
    if(!($('body').hasClass("pets") &&    ($('body').hasClass("edit") || $('body').hasClass("update") || $('body').hasClass("new") || $('body').hasClass("create"))       )) return;
    
    
    $("#pet_before_evolution").blur(searchProfileImage);
    $("#pet_before_evolution").keyup(searchProfileImage);
    
    $("#pet_after_evolution").blur(searchProfileImage);
    $("#pet_after_evolution").keyup(searchProfileImage);
    
    $("#pet_material_1").blur(searchProfileImage);
    $("#pet_material_1").keyup(searchProfileImage);
    
    $("#pet_material_2").blur(searchProfileImage);
    $("#pet_material_2").keyup(searchProfileImage);
    
    $("#pet_material_3").blur(searchProfileImage);
    $("#pet_material_3").keyup(searchProfileImage);
    
    $("#pet_material_4").blur(searchProfileImage);
    $("#pet_material_4").keyup(searchProfileImage);
    
    function searchProfileImage()
    {
        $("#search_profile_image_target").val($(this).attr("id")+"_pic");
        //console.log("target: "+$("#search_profile_image_target").val());
        $.ajax({
            type: "POST",
            url: $("#search_profile_image_url").val(), //sumbits it to the given url of the form
            data: { number: $(this).val() },
            //dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
        }).success(searchProfileImageSuccessHandler)
        .error(function(){
            alert("發生故障，請稍後再重試!");
        });
    }
    
    function searchProfileImageSuccessHandler(json)
    {
        //console.log("success", json);
        
        if(!json)
        {
            //console.log("not found");   
            getNotFound();
        }
        else
        {
             if(!json.get_profile_image) getDefaultImage(json.number);
            else getProfileImage(json.get_profile_image);
        }
        
    }
    
    function getDefaultImage(number)
    {
        var str_number  = get_str_number(number);
        var html = "<img src='/assets/pets/icon/"+str_number+".png' />";
        $("#"+$("#search_profile_image_target").val()+" span, #"+$("#search_profile_image_target").val()+" img").remove();
        $("#"+$("#search_profile_image_target").val()).append(html);
        console.log(html);   
    }
    
    function getProfileImage(url)
    {
        var html = "<img src='"+url+"' />";
        $("#"+$("#search_profile_image_target").val()+" span, #"+$("#search_profile_image_target").val()+" img").remove();
        $("#"+$("#search_profile_image_target").val()).append(html);
        console.log(html);   
    }
    
    function getNotFound()
    {
        var html = "<span>Not found</span>";
        $("#"+$("#search_profile_image_target").val()+" span, #"+$("#search_profile_image_target").val()+" img").remove();
        $("#"+$("#search_profile_image_target").val()).append(html);
        console.log(html);   
    }
    
    function get_str_number(v)
    {
        var i   = parseInt(v);
        
        if(i<10)
        {
            return "000"+i;     
        }
        else if(i<100)
        {
            return "00"+i;     
        }
        else if(i<1000)
        {
            return "0"+i;     
        }
        
        return v;
    }//end of get_str_number
    
    
    
});//End of ready