$( document ).ready(function() 
{
    
    if(!($('body').hasClass("pets") && $('body').hasClass("show"))) return;
    
    var ranking_modal_inst;
    
    $( "#hp_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_hp").val(ui.value);
        }//end change
    });
    
    $( "#attack_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_attack").val(ui.value);
        }//end change
    });
    
    $( "#ability_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_ability").val(ui.value);
        }//end change
    });
    
    $( "#leader_skill_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_leader_skill").val(ui.value);
        }//end change
    });
    
    $( "#skill_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_skill").val(ui.value);
        }//end change
    });
    
    $( "#skill_round_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_skill_round").val(ui.value);
        }//end change
    });
    
    $( "#arrow_slider" ).slider({
        max: 10,
        min: 0,
        step: 0.1,
        change: function( event, ui ) {
            $("#ranking_arrow").val(ui.value);
        }//end change
    });
    
    
    //$('#ranking_form').submit(ranking_form_submit);
    
    ranking_modal_inst = $('[data-remodal-id=ranking_modal]').remodal();
    $( "#visitor-post-botton" ).click(function(){
        ranking_modal_inst.open();
    });
    var is_submitting = false;
    $( "#visitor_ranking_submit_btn" ).click(function(){
        if(is_submitting) return;
        is_submitting = true;
        $('#ranking_form').submit();
    });
    
});//End of ready

