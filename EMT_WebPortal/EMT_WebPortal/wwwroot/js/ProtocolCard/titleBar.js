
class TitleBar extends HTMLElement {

    constructor(title, patientType) {

        this.titleBar = document.createElement("div");
        titleBar.id = title + "-" + patientType + "-title-bar";
        titleBar.classList.add('title-bar');

        this.title = document.createElement("p");
        this.title.classList.add('title-bar-title');
        this.title.innerHTML = title;

        this.patientType = document.createElement("p");
        this.patientType.classList.add('title-bar-patientType');
        this.patientType.innerHTML = patientType;

    }
}

customElements.define('title-bar', TitleBar);

export { TitleBar };