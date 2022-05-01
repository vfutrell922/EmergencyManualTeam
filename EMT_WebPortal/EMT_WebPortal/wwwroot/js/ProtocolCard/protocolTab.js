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

        this.buttonArea = new TabButtonArea(protocol);

        this.titleArea = document.createElement("div");
        this.titleArea.classList = ('title-area');

        this.certLevel = document.createElement("p");
        this.certLevel.innerHTML = protocol.certificationLevel;
        this.certLevel.classList = ('certification-level-title');

        this.titleArea.appendChild(this.certLevel);

        this.appendChild(this.titleArea);
        this.appendChild(this.buttonArea);
    }
}

customElements.define('protocol-tab', ProtocolTab);

export { ProtocolTab };