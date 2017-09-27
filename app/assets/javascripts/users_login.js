function users_login() 
{
    if(!($('body').hasClass("users") && $('body').hasClass("login"))) return;
    
    console.log('user login action~');
    
    $("#user_login").focus();
    
    $('.password_field_wrapper input').keypress(function (e) {
      if (e.which == 13) {
        $(".login_form").submit();
        return false;    //<---- Add this line
      }
    });    
}