import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
  static targets = [];

  hide() {
    this.element.classList.toggle('hidden');
  }

  remove() {
    this.element.remove();
  }
}
