import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

  submit(event) {
    event.preventDefault();
    const form = this.formTarget;
    const url = form.action;
    const data = new FormData(form);

    fetch(url, {
      method: "POST",
      body: data,
    })
      .then((response) => response.text())
      .then((html) => {
        const result = document.querySelector("#search-result");
        result.innerHTML = html;
      });
  }
}
