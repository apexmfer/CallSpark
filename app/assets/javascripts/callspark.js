 $(document).ready(function(){

    $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5();
    });




/*
auto load job role, mcmc account number, account manager id , service contract type 

*/


    //When a customer is chosen from autocomplete, autofill all other data

    $( ".customer-field:first" ).on( "autocompleteselect", function( event, ui ){
 //$( "#call_caller" ).on( "autocompleteselect", function( event, ui ){

        console.log('autocomplete select')




                var cust_id = ui.item.value;

              var custdatacall = $.ajax({
                url:'/calls/listinfo/'+cust_id, //Defined in your routes file
                //data:('id=' + ui.item.label  )
            } )
              .done(function(data) {
                  console.log( "success" );
                 console.log( data );
                 customer = data[0];
                 company = data[1];

                 $( ".customer-field:first" ).val(customer.name);
                  $( ".company-field:first" ).val(company.name);
                   $( ".bpid-field:first" ).val(company.BPID);
                    $( ".email-field:first" ).val(customer.email);
                     $( ".phone-field:first" ).val(customer.phone_number);

             })
              .fail(function() {
               console.log( "error" );
              })
              .always(function() {
                console.log( "complete" );
             });


        //this is ran upon autocomplete select
           var previouscalls = $.ajax({
              url:'/calls/history/'+cust_id, //Defined in your routes file

        } )
          .done(function(data) {


              var myNode = $(".previous-conversation-container:first");
          while (myNode.firstChild) {
              myNode.removeChild(myNode.firstChild);
          }


            console.log( "datagot call history" );
             console.log( data );

              for(var i=0;i<data.length;i++){
               var newdiv = document.createElement( "div" );
               newdiv.className+=" alert alert-info";
               newdiv.innerHTML = data[i].text.replace(/(?:\r\n|\r|\n)/g, '<br />');
                $(".previous-conversation-container:first").append( newdiv );

                var timelabel = document.createElement( "div" );
               timelabel.className+=" label label-primary pull-right";
               timelabel.innerHTML = jQuery.timeago(data[i].created_at) ;

              newdiv.appendChild( timelabel );
             }


           })
          .fail(function() {
             console.log( "error" );
          })
          .always(function() {
              console.log( "complete" );
         });

         }  );






  })
