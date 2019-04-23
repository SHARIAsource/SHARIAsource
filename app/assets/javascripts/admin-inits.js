var ready;

ready = function() {
  tinymce.remove()

  $(document).foundation()

  window.COLOR_MAP = [
    "222222", "Black",
    "646967", "Gray",
    "FAA52E", "Gold",
    "5C0113", "Crimson"
  ],

  $('select[multiple]').select2({
    placeholder: 'Select an option'
  })

  tinymce.init({
    selector: 'textarea.wysiwyg',
    toolbar: 'formatselect styleselect | fontselect fontsizeselect | forecolor backcolor | bold italic underline strikethrough superscript | bullist numlist blockquote | link unlink | image media table | undo redo | ltr rtl',
    plugins: 'link image table paste directionality media autosave',
    browser_spellcheck: true,
    style_formats: [{
      title: 'Footnote',
      block: 'p',
      classes: 'ss-footnote'
    }],
    menubar: false,
    color_map: COLOR_MAP,
    autosave_restore_when_empty: true,
    statusbar: false,
    paste_remove_styles: true,
    height: 250,
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })

  tinymce.init({
    selector: 'textarea.wysiwyg-summary',
    toolbar: 'fontselect fontsizeselect | italic link unlink | forecolor backcolor | bold italic underline strikethrough superscript | bullist numlist blockquote | image media | undo redo',
    plugins: 'link image media paste autosave',
    color_map: COLOR_MAP,
    browser_spellcheck: true,
    menubar: false,
    autosave_restore_when_empty: true,
    statusbar: false,
    paste_remove_styles: true,
    height: 150,
    content_css: $('meta[name="tinymce-content-css"]').attr('content')
  })
}
$(document).on('page:change', ready);
$(document).on('turbolinks:load', ready);

$(document).on('page:receive', function() {
});
