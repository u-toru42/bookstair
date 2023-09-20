import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "list"];

  async search(event) {
    const query = this.inputTarget.value;
    if (!query) {
      this.listTarget.innerHTML = "";
      return;
    }
    const response = await fetch(`/search?q=${encodeURIComponent(query)}`);
    const json = await response.json();
    const items = json.map(({ title, url }) => `<li><a href="${url}">${title}</a></li>`);
    this.listTarget.innerHTML = items.join("");
  }
}
