import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    console.log("Autocomplete controller connected");
  }

  async search() {
    const url = "/books/autocomplete"; // Qiita APIのエンドポイントに変更する
    const res = await fetch(url);
    const tags = await res.json();
    const input = this.inputTarget;
    const results = this.resultsTarget;
    const value = input.value;

    // テキストボックスが空の場合は何もしない
    if (value === "") {
      results.innerHTML = "";
      return;
    }

    const matchingTags = tags.filter((tag) =>
      tag.toLowerCase().startsWith(value.toLowerCase())
    );

    results.innerHTML = "";

    if (matchingTags.length > 0) {
      matchingTags.slice(0, 10).forEach((tag) => {
        const li = document.createElement("li");
        li.textContent = tag;
        li.setAttribute("tabindex", "0");
        li.setAttribute("role", "option");
        li.setAttribute("aria-selected", "false");
        li.classList.add("autocomplete-result");
        results.appendChild(li);
      });
    } else {
      const li = document.createElement("li");
      li.textContent = "タグが見つかりませんでした";
      li.classList.add("autocomplete-no-result");
      results.appendChild(li);
    }
  }

  select(event) {
    const input = this.inputTarget;
    const result = event.target;

    input.value = result.textContent.trim();
    this.resultsTarget.innerHTML = "";
  }

  submit(event) {
    event.preventDefault();
    const input = this.inputTarget;
    const value = input.value;
    if (value !== "") {
      const form = input.closest("form");
      form.action = "/books/search?title_search=" + encodeURIComponent(value);
      form.submit();
    }
  }
}
