// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

document.addEventListener("turbolinks:load", () => {
  const toast = document.querySelector("[data-toast]")
  if (toast) {
    window.setTimeout(() => {
      toast.style.opacity = "0"
      toast.style.transform = "translate(-50%, -8px)"
      toast.style.transition = "opacity .25s, transform .25s"
    }, 2800)
  }

  document.querySelectorAll(".task-actions").forEach((menu) => {
    menu.addEventListener("toggle", () => {
      if (!menu.open) return
      document.querySelectorAll(".task-actions[open]").forEach((otherMenu) => {
        if (otherMenu !== menu) otherMenu.removeAttribute("open")
      })
    })
  })

  document.querySelectorAll("[data-image-upload]").forEach((upload) => {
    const input = upload.querySelector("[data-image-input]")
    const preview = upload.querySelector("[data-image-preview]")
    const placeholder = upload.querySelector("[data-upload-placeholder]")

    input.addEventListener("change", () => {
      const file = input.files[0]
      if (!file) return

      preview.src = URL.createObjectURL(file)
      preview.style.display = "block"
      placeholder.style.display = "none"
      upload.classList.add("has-image")
    })
  })
})


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
