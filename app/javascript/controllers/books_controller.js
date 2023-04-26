import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  submit(event) {
    event.preventDefault();
    let form = this.formTarget;
    $.ajax({
      type: form.attr("method"),
      url: form.attr("action"),
      data: form.serialize(),
      success: function(response) {
        // successのコールバック処理
      },
      error: function(xhr, status, error) {
        // errorのコールバック処理
      }
    });
  }
}
