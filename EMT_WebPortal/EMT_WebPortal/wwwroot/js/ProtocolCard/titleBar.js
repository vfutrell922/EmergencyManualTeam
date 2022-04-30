
class TitleBar extends HTMLElement {

    constructor(title, patientType) {

        this.id = title + "-" + patientType + "-title-bar";
        this.classList = ('title-bar');

        this.title = document.createElement("p");
        this.title.classList = ('title-bar-title');
        this.title.innerHTML = title;

        this.patientType = document.createElement("p");
        this.patientType.classList = ('title-bar-patientType');
        this.patientType.innerHTML = patientType;
    }
}

customElements.define('title-bar', TitleBar);

export { TitleBar };