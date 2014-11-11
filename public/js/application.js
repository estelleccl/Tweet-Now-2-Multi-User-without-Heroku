// $(document).ready(function() {
//   // This is called after the document has loaded in its entirety
//   // This guarantees that any elements we bind to will exist on the page
//   // when we try to bind to them

//   // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
// });

  $(document).ready(function()
    { 
      populate_tweets();

      function populate_tweets()
        {
          console.log("test")
          $.ajax(
          {
            url:'/tweet',
            type: "GET",
            success:function(result)
            {
              $("#show_tweet").html(result);
              $('#status').hide();
              $("#wait-msg").hide();
            },
            error: function(jqXHR, textStatus, errorThrown) 
            {
              $("#wait-msg").hide();
            }
          });
        };

      $("#post_tweet").submit(function(event)
        { 
          console.log("test1")
          $('#status').show();
          $("#wait-msg").show();
          var postData = $(this).serializeArray();
          var formURL = $(this).attr("action");
          $.ajax(
          {
              url : formURL,
              type: "POST",
              data : postData,
              success:function(result)
              {
                $("#status").html('Tweeting');
                setTimeout(function(){ check_job_status(result) }, 1000);
                populate_tweets();
                $("#wait-msg").hide();
                document.getElementById("post_tweet").reset();
              },
              error: function(jqXHR, textStatus, errorThrown)
              {
                $("#wait-msg").hide();
              }
          });
          event.preventDefault(); //STOP default action
        });

      function check_job_status(job_id)
        {
          var request = $.ajax(
          {
            type: "GET",
            url: '/status/' + job_id
          });
          request.done(function(response){
            if (response === 'true'){
              $('#status').text('Done');
            } else {
              setTimeout(function(){ check_job_status(job_id) }, 1000);
            }
          });
        };

      $("#post_tweet_later").submit(function(event)
        { 
          console.log("test2")
          $('#status').show();
          // $("#wait-msg").show();
          var postData = $(this).serializeArray();
          $.ajax(
          {
              url : '/tweet_later',
              type: "POST",
              data : postData,
              success:function(result)
              {
                $("#status").html('Tweeting');
                setTimeout(function(){ check_job_status(result) }, 1000);
                populate_tweets();
                $('#status').hide();
                document.getElementById("post_tweet_later").reset();
              },
              error: function(jqXHR, textStatus, errorThrown)
              {
                $("#status").html('Tweet Failed');
              }
          });
          populate_tweets();
          event.preventDefault(); //STOP default action
        });
    });
