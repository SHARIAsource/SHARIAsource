var $document = $(document)

$document.on('page:change', function() {
  $document.foundation()
  $('select[multiple]').chosen()
  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect | bold italic underline strikethrough | bullist numlist blockquote | link unlink | table | undo redo',
    plugins: 'link table',
    menubar: false,
    statusbar: false,
    height: 250
  })
})
