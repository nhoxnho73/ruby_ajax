$(document).ready(function() {

  // load_genre();
  // function load_genre() {
  //   $.ajax({
  //     url: "update_movie_list",
  //     data: {
  //       genre_id : $('#select_genre').val()
  //     },
  //     method: 'GET',
  //     success: function(data) {
  //       var movies = data.movies;
  //       var movie = '';
  //       for (let i = 0; i < movies.length; i++) {
  //         movie += "<li><input id='list_movie' type='checkbox' multiple='true'  name='list_movie[]' value='" + movies[i].name + "'>" + movies[i].name + "</li>"
  //       }
  //       $('#movieDiv').html(
  //         `<ul>${movie}</ul>`
  //       )
  //     }
  //   });
  // }

  $('#select_genre').change(function() {
    $.ajax({
      url: "update_movie_list",
      data: {
        genre_id : $('#select_genre').val()
      },
      method: 'GET',
      success: function(data) {
        var movies = data.movies;
        var movie = '';
        for (let i = 0; i < movies.length; i++) {
          movie += "<li><input id='list_movie' type='checkbox' multiple='true'  name='list_movie[]' value='" + movies[i].name + "'>" + movies[i].name + "</li>"
        }
        $('#movieDiv').html(
          `<ul>${movie}</ul>`
        )
      }
    });
  });
  
  var listMovie = []
  $('body').on('click', '#list_movie', function(){
    check = listMovie.includes($(this).val())
    if (!check) {
      listMovie.push($(this).val())
    }
    else
    {
      listMovie.splice(listMovie.indexOf($(this).val()), 1);
    }
  });

  var listYear = []
  $('body').on('click', '#list_year', function(){
    check = listYear.includes($(this).val())
    if (!check) {
      listYear.push($(this).val())
    }
    else
    {
      listYear.splice(listYear.indexOf($(this).val()), 1);
    }
  });

  var listKeyword = []
  $('body').on('click', '#list_keyword', function(){
    check = listKeyword.includes($(this).val())
    if (!check) {
      listKeyword.push($(this).val())
    }
    else
    {
      listKeyword.splice(listKeyword.indexOf($(this).val()), 1);
    }
  });

  $('.search_movie').click(function() {
    $.ajax({
      url: "search_movie_lists",
      method: 'GET',
      data: {
        list_movie : listMovie,
        list_year : listYear,
        list_keyword : listKeyword,
        list_search  : $("#search_name_movie").val() === null ? null : $("#search_name_movie").val()
      },
      success: function(data) {
        var searchs = data.searchs;
        var search = '';
        if (searchs != undefined){
          for (let i = 0; i < searchs.length; i++) {
            search +="<tr>"
              +"<td>"+searchs[i].name+"</td>"
              +"<td>"+searchs[i].director+"</td>"
              +"<td>"+searchs[i].star+"</td>"
              +"<td>"+searchs[i].release_date+"</td>"
              + `<td><a href="${searchs[i].summary}">${searchs[i].summary}</a></td>`
            + "</tr>"
          }
          $('#showList').html(
            `<table class="table table-striped sortable" id="dataTable" style="width:100%;">
            <thead>
              <tr> 
                <td><strong>Name</strong></td>
                <td><strong>Director</strong></td>
                <td><strong>Star</strong></td>
                <td><strong>Release Date</strong></td>
                <td><strong>Summary</strong></td>
              </tr>
            </thead>
            <tbody>
              ${search} 
            </tbody>
          </table>`
          )
          $('#dataTable').DataTable({
            dom: 'C<"clear">lfrtip',
            "searching": false,
            "paging":   true,
            "ordering": true,
            "info":   false,
            "lengthMenu": [5],
            "bLengthChange": false,
            "aoColumns": [{
                "bSortable": true
            },
            {
                "bSortable": false
            },
            {
                "bSortable": false
            },
            {
                "bSortable": true
            },
            {
                "bSortable": false
            }]
          });
        }
        else
        {
          alert("value not blank");
        }
      },
      error: function(errorThrown){
        alert(errorThrown);
        alert("There is an error with AJAX!");
      }   

    });
  });

  $("#advance_saerch").click(function(){
    $(".show_advance_search").toggle();
  });

});

