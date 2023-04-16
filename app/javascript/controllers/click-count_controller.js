import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['count'];

  async update() {
    const response = await fetch(this.data.get('url'), { method: 'PATCH' });
    const data = await response.json();
    this.countTarget.textContent = data.count;
  }
}
