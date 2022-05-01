import {
    TabButtonArea
} from './tabButtonArea.js';

class ProtocolTab extends HTMLElement
{
    constructor(protocol)
    {
        super();

        this.id = protocol.title + '-' + protocol.patientType + '-' + protocol.certificationLevel + '-protocol-tab';
        this.classList = ('protocol-tab');

        let buttonArea = new TabButtonArea(protocol);

        let titleArea = document.createElement("div");
        titleArea.classList = ('title-area');

        let certLevel = document.createElement("p");
        certLevel.innerHTML = protocol.certificationLevel;
        certLevel.classList = ('certification-level-title');

        titleArea.appendChild(this.certLevel);

        this.appendChild(titleArea);
        this.appendChild(buttonArea);
    }
}

customElements.define('protocol-tab', ProtocolTab);

export { ProtocolTab };