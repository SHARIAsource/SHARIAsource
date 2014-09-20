(function() {
  $(document).on('change.radio', 'input[type=radio]', function(event) {
    var $this = $(this)
    var name = $this.attr('name')
    var $group = $('input[type=radio][name=' + name + ']')
    $group.parent('label').removeClass('selected')
    $group.filter(':checked').parent('label').addClass('selected')
  })
}())
