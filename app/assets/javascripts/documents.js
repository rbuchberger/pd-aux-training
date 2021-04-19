// Auto-update the page when changing the sort setting
function addSortListener() {
  form = document.querySelector('form[action="/documents"]')
  select = document.querySelector('select[name="sort_by"]')
  if(!select) { return }

  select.addEventListener('change', () => form.submit())
}

// Client side file size validation
function checkFileSize(e) {
  file = e.target.files[0]

  // File exists and is bigger than 100mb
  if(file && file.size > 104857600) {
    e.target.labels[0].classList.add('border', 'border-danger')
    p = document.createElement('p')
    p.innerText = "Files may not be larger than 100 MB."
    p.id = "file-size-warning"
    e.target.parentElement.appendChild(p)
    document.querySelector('input[value="Save"]').disabled = true
  } else {
    p = document.querySelector("#file-size-warning")
    if(p) { p.remove() }
    document.querySelector('input[value="Save"]').disabled = false
    e.target.labels[0].classList.remove('border', 'border-danger')
  }
}

function addFileListener() {
  fileForm = document.querySelector('input[name="document[file]"]')
  if(!fileForm) { return }

  fileForm.addEventListener('change', checkFileSize)
}

// Add all our listeners
function setupListeners() {
  // Required for filename display in the custom file input form
  bsCustomFileInput.init()

  addSortListener()
  addFileListener()
}

document.addEventListener('turbolinks:load', setupListeners)
