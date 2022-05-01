
class TitleBar extends HTMLElement {

    constructor(title, patientType) {

        super();

        this.id = title + "-" + patientType + "-title-bar";
        this.classList = ('title-bar');

        this.titleParagraph = document.createElement("p");
        this.titleParagraph.innerText = title;

        this.patientType = document.createElement('p');
        this.patientType.innerHTML = patientType;

        this.appendChild(this.titleParagraph);
        this.appendChild(this.patientType);
    }
}

customElements.define('title-bar', TitleBar);

export { TitleBar };