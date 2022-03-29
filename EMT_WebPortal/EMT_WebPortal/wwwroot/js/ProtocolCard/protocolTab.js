import {
    TabButtonArea
} from './tabButtonArea.js';

class ProtocolTab extends HTMLElement
{
    constructor(certificationLevel)
    {
        super();

        let protocolTab = document.createElement("div");

        let buttonArea = new TabButtonArea();

        let titleArea = document.createElement("div");
        titleArea.classList.add('title-area');
        let certLevel = document.createElement("p");
        certLevel.innerHTML = certificationLevel;
        certLevel.classList.add('certification-level');
        titleArea.appendChild(this.certLevel);

        protocolTab.appendChild(titleArea);
        protocolTab.appendChild(buttonArea);

        return protocolTab;
    }
}

customElements.define('protocol-tab', ProtocolTab);

export { ProtocolTab };