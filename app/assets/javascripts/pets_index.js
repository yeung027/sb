$( document ).ready(function() 
{
    
    if(!($('body').hasClass("pets") && $('body').hasClass("index"))) return;
    
    var ajaxBusy    = false;
    
    hiddenValueToSelect();
    petsItem_is_appear_checker();
    
    $("#search-form-graybox .field_wrapper ul.boxs_wrapper li.item").click(function() 
    {
        if(ajaxBusy) return;
        var fieldWrapperId  = $(this).parent().parent().attr('id');
        var isSameItem  = $(this)[0]==$("#search-form-graybox #"+fieldWrapperId +" li.selected")[0];
        $("#search-form-graybox #"+fieldWrapperId +" li.selected").removeClass("selected");
        
        if(isSameItem)
        {
            $("#"+fieldWrapperId+" input.hidden_value").val("");
        }//end is same if
        else
        {
            $(this).addClass( "selected" );
            $("#"+fieldWrapperId+" input.hidden_value").val($(this).attr('data-search-value'));
        }//end is same else
        
        $('form.pets_search_form').submit();
    }); //end of li.item onclick handler
    
    $('form.pets_search_form').submit(postForm);
    $('form.pets_search_form').submit();
    
    function postForm()
    {
        setAjaxBusy(true);
        //console.log("post form~");
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            type: "POST",
            url: $(this).attr('action'), //sumbits it to the given url of the form
            data: valuesToSubmit,
            //dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
        }).success(postFormSuccessHandler)
        .error(function(){
            console.log("發生故障，請稍後再重試!");
            setAjaxBusy(false);
        });
        
        return false; // prevents normal behaviour
    }//end of postForm
    
    function postFormSuccessHandler(json)
    {
        //console.log("success", json[0].number);
        //console.log($(".pets_list li.item"));
        
        $(".pets_list li").remove();
        $(".pets_list div.spinner").remove();
        var html;
        $.each(json, function(i, item) {
            html    = "<li class='item' pet-number='"+item.number+"' itemscope itemtype='https://schema.org/Character'>";
            html    += "<a href='/pets/"+item.number+"' itemprop='url'>";
            html    += "<div style='display:none' itemprop='name'>"+item.name+"</div>";
            html    += "<div class='img-wrapper'>";
            if(item.get_profile_image!=null)
                html    += "<img itemprop='image' class='unload' _src='"+item.get_profile_image+"' />";
            else
                html    += "<img itemprop='image' class='unload' _src='/assets/pets/icon/"+get_str_number(item.number)+".png' />";
            html    += "</div>";
            html    += "</a>";
            html    += "</li>";
            $(".pets_list").append(html);
        });
        
        html = "<div class='clearer'></div>";
        $(".pets_list").append(html);
        petsItem_is_appear_checker();
        setAjaxBusy(false);
    }//end of postFormSuccessHandler
    
    
    
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

    function petsItem_is_appear_checker()
    {
        //console.log(isElementVisible($('body')));
        $(".pets_list li.item .img-wrapper img.unload").each(function( index ) {
            //console.log( index + ": " + $( this ).attr("_src") );
            if(isElementVisible($(this).parent()))
            {
                //console.log( $( this ).attr("_src") );
                $( this ).attr("src", $( this ).attr("_src")); 
                $( this ).removeClass("unload");
                $(this).load(function() {
                    $( this ).fadeTo( 700 , 1, function() {
                        // Animation complete.
                    });
                });
                
            }
            
        });//end each img   
    }//end of petsItem_is_appear_checker
    
    
    function hiddenValueToSelect()
    {
        $("#search-form-graybox .field_wrapper input:hidden").each(function( index ) {
            var htnValue   = $( this ).val();
            
            $("#"+$(this).parent().attr("id")+" li.item").each(function( index ) {
                //console.log( "count" );
                var dataVal    = $(this).attr("data-search-value");
                if(dataVal==htnValue)
                {
                    $(this).addClass( "selected" );
                    return false;
                }//end if
            });//end each li.item   
        });//end each hidden   
        
        
    }//end of hiddenValueToSelect
    
    $(window).scroll(function() {
        petsItem_is_appear_checker();
    });
    
    $( window ).resize(function() {
        petsItem_is_appear_checker();
    });
    
    function setAjaxBusy(v)
    {
        ajaxBusy = v;
        if(v)
        {
            $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .search-form-graybox-wrapper .search-form-graybox-inner .mask").css("display", "block");
            $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .number-search-box-wrapper input[type=text]").attr("readOnly", true);
            $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .number-search-box-wrapper input[type=submit]").addClass("disabled");
        }
        else
        {
              $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .search-form-graybox-wrapper .search-form-graybox-inner .mask").css("display", "none");  
              $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .number-search-box-wrapper input[type=text]").attr("readOnly", false);
              $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .number-search-box-wrapper input[type=submit]").removeClass("disabled");
              $(".pets-wrapper .pets-content-wrapper .search-form-wrapper .number-search-box-wrapper input[type=text]").focus();
        }
    }
    
});//End of ready
