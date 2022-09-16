import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  removeClassIfExist(target_element, className) {
    if(target_element == null) return;
    if(className == null) return;

    if(target_element.classList.contains(className))
      target_element.classList.remove(className);
  }

  addClassUnlessExist(target_element, className) {
    if(target_element == null) return;
    if(className == null) return;

    if(!target_element.classList.contains(className))
      target_element.classList.add(className);
  }
}
