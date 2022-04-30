import {
    TabButtonArea
} from './tabButtonArea.js';

class ProtocolTab extends HTMLElement
{
    constructor(title, patientType, certificationLevel)
    {
        super();

        this.id = title + '-' + patientType + '-' + certificationLevel + '-protocol-tab';
        this.classList = ('protocol-tab');

        let buttonArea = new TabButtonArea(title, patientType, certificationLevel);

        let titleArea = document.createElement("div");
        titleArea.classList = ('title-area');

        let certLevel = document.createElement("p");
        certLevel.innerHTML = certificationLevel;
        certLevel.classList = ('certification-level-title');

        titleArea.appendChild(this.certLevel);

        this.appendChild(titleArea);
        this.appendChild(buttonArea);
    }
}

customElements.define('protocol-tab', ProtocolTab);

export { ProtocolTab };