import {
    ProtocolTab
} from './protocolTab.js';

class TabArea extends HTMLElement
{
    constructor(title, patientType)
    {
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
    addTab(id, certificationLevel) {
        switch (certificationLevel)
        {
            case CONFIG.CERTIFICATION_LEVEL.ALL:
                if (this._hasAll) break;
                this.createTab(id, this.title, this.patientType, certificationLevel);
                this._hasAll = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.EMT:
                if (this._hasEMT) break;
                this.createTab(id, this.title, this.patientType, certificationLevel);
                this._hasEMT = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.AEMT:
                if (this._hasAEMT) break;
                this.createTab(id, this.title, this.patientType, certificationLevel);
                this._hasAEMT = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.PARA:
                if (this._hasPARA) break;
                this.createTab(id, this.title, this.patientType, certificationLevel);
                this._hasPARA = true;
                break;
            default:
                break;
        }
    }

    // Creates a new tab and appends it to the tab area.
    createTab(id, title, patientType, certificationLevel)
    {
        let newTab = new ProtocolTab(title, patientType, certificationLevel);
        this.tabArea.appendChild(newTab);
    }
}

customElements.define('tab-area', TabArea);

export { TabArea };