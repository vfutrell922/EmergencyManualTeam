import {
    ProtocolTab
} from './protocolTab.js';

class TabArea extends HTMLElement
{
    constructor(title, patientType)
    {
        this._hasAll = false;
        this._hasEMT = false;
        this._hasAEMT = false;
        this._hasPARA = false;

        this.allTab = {};
        this.emtTab = {};
        this.aemtTab = {};
        this.paraTab = {};

        this.tabArea = document.createElement("div");
        this.tabArea.id = title + '-' + patientType + '-tab-area';
        this.tabArea.classList.add('tab-area');

        return this.tabArea;
    }

    addTab(certificationLevel) {
        switch (certificationLevel)
        {
            case CONFIG.CERTIFICATION_LEVEL.ALL:
                if (this._hasAll) break;
                this.allTab = createTab(certificationLevel);
                this._hasAll = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.EMT:
                if (this._hasEMT) break;
                this.emtTab = createTab(certificationLevel);
                this._hasEMT = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.AEMT:
                if (this._hasAEMT) break;
                this.aemtTab = createTab(certificationLevel);
                this._hasAEMT = true;
                break;
            case CONFIG.CERTIFICATION_LEVEL.PARA:
                if (this._hasPARA) break;
                this.paraTab = createTab(certificationLevel);
                this._hasPARA = true;
                break;
            default:
                break;
        }
    }


    // TODOVINCE: Finish implementing
    createTab(certificationLevel)
    {
        let newTab = new ProtocolTab(certificationLevel);
        this.tabArea.appendChild(newTab);
    }
}

customElements.define('tab-area', TabArea);

export { TabArea };