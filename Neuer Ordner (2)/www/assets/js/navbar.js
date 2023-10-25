  //menu transition js
  $(document).ready(function(){
    $('#form-1').show();
    $('#pills-home-tab').on('click', function() {
      $('#form-1').show();
      $('#form-2').hide();
      $('#form-3').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });

    $('#pills-var1-tab').on('click', function() {
      $('#form-2').show();
      $('#form-1').hide();
      $('#form-3').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });

    $('#pills-var2-tab').on('click', function() {
      $('#form-3').show();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });
    
    $('#pills-var3-tab').on('click', function() {
      $('#form-4').show();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-3').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });
    
    $('#pills-var4-tab').on('click', function() {
      $('#form-5').show();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-3').hide();
      $('#form-4').hide();
      $('#form-6').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });
    
    $('#pills-var5-tab').on('click', function() {
      $('#form-6').show();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-3').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-7').hide();
      $('#form-8').hide();
    });
    
    $('#pills-var6-tab').on('click', function() {
      $('#form-7').show();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-3').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-8').hide();
    });

    $('#pills-contact-tab').on('click', function() {
      $('#form-8').show();
      $('#form-3').hide();
      $('#form-1').hide();
      $('#form-2').hide();
      $('#form-4').hide();
      $('#form-5').hide();
      $('#form-6').hide();
      $('#form-7').hide();
    });

    $('.x-logo-white').hide();
    $(".nav-link").css("font-weight", "bold");
    $(".nav-link").css("color", "white");
    $(window).scroll(function(){
        var scroll = $(window).scrollTop();
        console.log(scroll);
        if (scroll > 0) {
          $(".navbar").addClass("navbar-scroll");
          $(".navbar").removeClass("bg-transparent");
          $(".x-logo-init").show();
          $('.x-logo-white').hide();
        }
        else {
            $(".navbar").removeClass("navbar-scroll");
            $(".navbar").addClass("bg-transparent")
            $(".x-logo-init").show();
            $('.x-logo-white').hide();
        }
        if (scroll > 10) {
          $(".navbar").css("background-color", "#b7e3de");
          $(".navbar-brand").addClass("text-dark");
          $(".nav-link").addClass("text-dark");
          $(".nav-link").css("font-weight", "bold");
          $(".x-logo-init").hide();
          $('.x-logo-white').show();
        } else {
            $(".navbar").css("background-color", "transparent");
            $(".navbar-brand").removeClass("text-dark");
            $(".nav-link").removeClass("text-dark"); 
            $(".x-logo-init").show();
            $('.x-logo-white').hide(); 	
        }
    })
  })
  
