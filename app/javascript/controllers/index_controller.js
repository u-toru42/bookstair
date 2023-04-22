import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "list" ]

  connect() {
    this.inputTarget.addEventListener("input", () => {
      const query = this.inputTarget.value

      if (query.length > 1) {
        fetch(`/books/autocomplete?q=${encodeURIComponent(query)}`)
          .then(response => response.json())
          .then(data => {
            this.listTarget.innerHTML = ""

            data.forEach(book => {
              const item = document.createElement("li")
              item.textContent = book.title
              this.listTarget.appendChild(item)
            })
          })
      } else {
        this.listTarget.innerHTML = ""
      }
    })
  }
}
