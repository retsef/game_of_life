import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
  static targets = ['backdrop', 'dialog', 'close'];

  static values = { }

  connect() {
    this.show();
  }

  show() {
    // this.element.style.setProperty('display', 'block');

    this.removeClassIfExist(this.backdropTarget, 'hidden');
    this.removeClassIfExist(this.dialogTarget, 'hidden');
  }

  close() {
    this.addClassUnlessExist(this.backdropTarget, 'hidden');
    this.addClassUnlessExist(this.dialogTarget, 'hidden');
  }

  cancel() {
    this.close();
  }

  confirm() {

  }

  remove() {
    this.element.remove();
  }
}
