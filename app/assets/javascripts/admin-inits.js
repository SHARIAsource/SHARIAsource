var $document = $(document)

$document.on('page:change', function() {
  $document.foundation()
  $('select[multiple]').chosen()
  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect | bold italic underline strikethrough | bullist numlist blockquote | link unlink | table | undo redo | ltr rtl',
    plugins: 'link table paste directionality',
    menubar: false,
    statusbar: false,
    paste_remove_styles: true,
    height: 250
  })
})
