import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
  static targets = ['button', 'sidebar', 'button_icon_closed', 'button_icon_opened'];

  toggle() {
    this.sidebarTarget.classList.toggle('hidden');
    this.setIconBySidebar();
  }

  show() {
    this.removeClassIfExist(this.sidebarTarget, 'hidden');
    this.setIconBySidebar();
  }

  hide() {
    this.addClassUnlessExist(this.sidebarTarget, 'hidden');
    this.setIconBySidebar();
  }

  setIconBySidebar() {
    if(this.sidebarTarget.classList.contains('hidden')) {
      console.log('show icon opened');
      this.showIconOpened();
    } else {
      console.log('show icon closed');
      this.showIconClosed();
    }
  }

  showIconOpened() {
    this.button_icon_closedTarget.classList.add('hidden');
    this.button_icon_closedTarget.classList.remove('block');

    this.button_icon_openedTarget.classList.remove('hidden');
    this.button_icon_openedTarget.classList.add('block');
  }

  showIconClosed() {
    this.button_icon_closedTarget.classList.remove('hidden');
    this.button_icon_closedTarget.classList.add('block');

    this.button_icon_openedTarget.classList.add('hidden');
    this.button_icon_openedTarget.classList.remove('block');
  }
}
