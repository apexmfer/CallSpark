


function toggleFavoriteCompany(element)
{

  var button = $(element);
  var star = button.find('.fa:first');
  var span = button.find('span:first');

  var company_id =  button.attr("data-company-id")


  var favorited = $(star).hasClass( "fa-star" );

  if(favorited)
  {


    $.ajax({
    method: "POST",  
    url:  "/unfavorite_company",
    data: {id: company_id}
   })
    .done(function( response ) {
      console.log(response);

      $(star).removeClass("fa-star");
      $(star).addClass("fa-star-o");

      $(span).html("Add To Favorites");
    });

  }
  else
  {


    $.ajax({
    method: "POST",
    url:  "/favorite_company",
    data: {id: company_id}
   })
    .done(function( response ) {
      console.log(response);

      $(star).removeClass("fa-star-o");
      $(star).addClass("fa-star");

      $(span).html("Favorited");
    });

  }





}
