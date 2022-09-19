import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
  static targets = ['button', 'panel'];

  toggle() {
    this.panelTarget.classList.toggle('hidden');
  }

  show() {
    this.removeClassIfExist(this.panelTarget, 'hidden');
  }

  hide() {
    this.addClassUnlessExist(this.panelTarget, 'hidden');
  }
}
