// fileupload staff
$(function () {
  // disable dropping to a whole page
  $(document).bind('drop', function (e) {
    e.preventDefault();
  });

// dragstart
// drag
// dragenter
// dragleave
// dragover
// drop
// dragend
  $(document).bind('dragstart drag dragenter dragover dragend', function (e) {
    var dropZone = $('#dropzone');
    $('#info, footer').addClass('blur');
  });

  $(document).bind('drop', function (e) {
    $('#info, footer').removeClass('blur');
  });

  $(document).bind('dragleave', function (e) {
    setTimeout("$('#info, footer').removeClass('blur')", 1000);
  });

  $('#fileupload').fileupload({
    dataType: 'json',
    dropZone: $('#dropzone'),
    acceptFileTypes: /(\.|\/)(png|gif|jpg|jpeg)$/i,
    maxFileSize: 10000000,
    done: function (e, data) {
      $.each(data.result.icon, function (index, file) {
        var link = "<a href='/" + file.url + "' target='_blank'>download</a>";
        $('#result').html(link).hide().fadeIn();
      });
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('#progress .progress-bar').css(
        'width',
        progress + '%'
      );
    }
  }).on('fileuploadprocessalways', function (e, data) {
    var currentFile = data.files[data.index];
    if (data.files.error && currentFile.error) {
      $('#error').html('Wrong extension').fadeIn();
    }
    else {
      $('#error').fadeOut();
    }
  });
});

