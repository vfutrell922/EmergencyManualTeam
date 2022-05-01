import {
    ProtocolTab
} from './protocolTab.js';

class TabArea extends HTMLElement
{
    constructor(title, patientType)
    {
        super();

        this.title = title;
        this.patientType = patientType;
        this.hasAll = false;
        this.hasEMT = false;
        this.hasAEMT = false;
        this.hasPARA = false;

        this.id = title + '-' + patientType + '-tab-area';
        this.classList = ('tab-area');
    }

    // Will create a new tab of the the provided certificatio level, if one does not already exist.
    addTab(protocol) {
        switch (protocol.certificationLevel)
        {
            case 3:
                if (this._hasAll) break;
                this.createTab(protocol);
                this._hasAll = true;
                break;
            case 0:
                if (this._hasEMT) break;
                this.createTab(protocol);
                this._hasEMT = true;
                break;
            case 1:
                if (this._hasAEMT) break;
                this.createTab(protocol);
                this._hasAEMT = true;
                break;
            case 2:
                if (this._hasPARA) break;
                this.createTab(protocol);
                this._hasPARA = true;
                break;
            default:
                break;
        }
    }

    // Creates a new tab and appends it to the tab area.
    createTab(protocol)
    {
        let newTab = new ProtocolTab(protocol);
        this.tabArea.appendChild(newTab);
    }
}

customElements.define('tab-area', TabArea);

export { TabArea };