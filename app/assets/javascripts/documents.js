// Auto-update the page when changing the sort setting
function addSortListener() {
  form = document.querySelector('form[action="/documents"]')
  select = document.querySelector('select[name="sort_by"]')

  select.addEventListener('change', () => form.submit())
}

document.addEventListener('DOMContentLoaded', addSortListener)
