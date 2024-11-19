class ConsentManager
{
    static defaultOptions = {
        prefix: 'consent',
        storageKey: 'consent',
        version: 1,
        viewsUntilBannerIsShown: $('#consent-manager-show-banner').val(),
        eventReadyName: 'consent.ready',
        eventUpdatedName: 'consent.updated'
    };

    constructor(options)
    {
        this.options = Object.assign({}, ConsentManager.defaultOptions, options);
        this.$manager = document.getElementById(this.options.prefix + '-manager');
        this.$banner = document.getElementById(this.options.prefix + '-banner');
        this.$collapseToggle = this.$manager.querySelectorAll('[data-collapse]');
        this.$bannerBtnAcceptAll = document.getElementById(this.options.prefix + '-banner-btn-all');
        this.$bannerBtnClose = document.getElementById(this.options.prefix + '-banner-btn-close');
        this.$bannerBtnSettings = document.getElementById(this.options.prefix + '-banner-btn-settings');
        this.$modalSettings = document.getElementById(this.options.prefix + '-settings');
        this.$modalSettingsCheckboxes = this.$modalSettings.querySelectorAll('[data-storage-key]');

        this.$modalSettingsCheckAll = this.$modalSettings.querySelectorAll(
            '[data-toggle="' + this.options.prefix + '-all"]'
        );

        this.$modalConfirm = document.getElementById(this.options.prefix + '-confirm');
        this.$modalConfirmBtnOnce = document.getElementById(this.options.prefix + '-btn-once');
        this.$modalConfirmBtnAlways = document.getElementById(this.options.prefix + '-btn-always');
        this.$modalConfirmKeyInput = document.getElementById(this.options.prefix + '-confirm-key');
        this.$modalConfirmHeadline = document.getElementById(this.options.prefix + '-confirm-info-headline');
        this.$modalConfirmHelp = document.getElementById(this.options.prefix + '-confirm-info-help');

        this.$modalConfirmDescription = document.getElementById(
            this.options.prefix + '-confirm-info-description'
        );

        this.$modalClose = document.querySelectorAll('[data-toggle="' + this.options.prefix + '-close"]');
        this.$btnOpenSettings = document.getElementById(this.options.prefix + '-settings-btn');
        this._isModalOpen = false;
        this._confirmCallback = null;
        this._checkVersion();
        this._events();
        this._init();
    }

    openModal(modal)
    {
        this._isModalOpen = true;
        document.body.style.overflow = 'hidden';
        modal.classList.add('active');
        setTimeout(() => modal.classList.add('show'), 10);
    }

    closeModal(event)
    {
        let modal = document.querySelector('.' + this.options.prefix + '-modal.active');

        if(!this._isModalOpen || event && modal !== event.target) {
            return;
        }

        if(modal !== null) {
            document.body.style.overflow = '';
            this._isModalOpen = false;
            modal.classList.remove('show');
            setTimeout(() => modal.classList.remove('active'), 200);
        }
    }

    closeBanner()
    {
        this.$manager.classList.add('fading');

        setTimeout(
            () => {
                this.$manager.classList.add('mini');
                this.$manager.classList.remove('fading');
            },
            200
        );
    }

    setSetting(key, value)
    {
        let settings = {};

        if (key === '*') {
            for(const modalSettingsCheckbox of this.$modalSettingsCheckboxes) {
                let key = modalSettingsCheckbox.getAttribute('data-storage-key');
                settings[key] = value;
            }
        } else if(typeof key === 'string') {
            settings[key] = value;
        } else {
            settings = key;
        }

        this.closeBanner();
        this._setStorageData(settings);

        document.dispatchEvent(
            new CustomEvent(this.options.eventUpdatedName, {
                detail: this._getLocalData() !== null && this._getLocalData().settings
            })
        );
    }

    openConfirmationModal(key, confirmCallback = () => {})
    {
        let checkbox = this.$modalSettings.querySelector('[data-storage-key="' + key + '"]');

        if (checkbox !== null) {
            let consentSwitch = checkbox.parentElement;
            let label = consentSwitch.querySelector('.' + this.options.prefix + '-label');
            let help = consentSwitch.querySelector('.' + this.options.prefix + '-help');
            let moreDescription = consentSwitch.querySelector('.' + this.options.prefix + '-more-description');

            this._confirmCallback = confirmCallback;
            this.$modalConfirmKeyInput.setAttribute('value', key);
            this.$modalConfirmHeadline.innerHTML = label.innerHTML;
            this.$modalConfirmHelp.innerHTML = help.innerHTML;
            this.$modalConfirmDescription.innerHTML = moreDescription.innerHTML;
            this.openModal(this.$modalConfirm);
        }
    }

    getSettings(key)
    {
        let localData = this._getLocalData();

        if(localData && localData.settings) {
            return localData.settings[key];
        }

        return false;
    }

    _init()
    {
        let sessionData = this._getSessionData() ?? {views: 0};
        sessionData.views ++;

        if(sessionData.views < this.options.viewsUntilBannerIsShown) {
            this.$banner.classList.add(this.options.prefix + '-hidden');
        }

        if(this._getLocalData() !== null) {
            this.$manager.classList.add('mini');
        }

        this.$manager.classList.add('active');
        this._updateSettings();
        sessionStorage.setItem(this.options.storageKey, JSON.stringify(sessionData));

        document.dispatchEvent(new CustomEvent(
            this.options.eventReadyName,
            {detail: this._getLocalData() !== null && this._getLocalData().settings}
        ));
    }

    _confirmationClick(permanent)
    {
        let confirmKey = this.$modalConfirmKeyInput.getAttribute('value');

        if(permanent) {
            this.setSetting(confirmKey, true);
        }

        if(this._confirmCallback) {
            this._confirmCallback();
        }

        this.closeModal();
    }

    _getSessionData()
    {
        return JSON.parse(sessionStorage.getItem(this.options.storageKey));
    }

    _getLocalData()
    {
        return JSON.parse(localStorage.getItem(this.options.storageKey));
    }

    _setStorageData(settings = {})
    {
        let localData = this._getLocalData();

        if(localData && typeof localData.settings === 'object') {
            settings = Object.assign({}, localData.settings, settings);
        }

        localStorage.setItem(
            this.options.storageKey,
            JSON.stringify({version: this.options.version, settings})
        );

        this._updateSettings();
    }

    _updateSettings()
    {
        let localData = this._getLocalData();
        let agreedCount = 0;

        if(localData !== null) {
            for(const modalSettingsCheckbox of this.$modalSettingsCheckboxes) {
                let storageKey = modalSettingsCheckbox.getAttribute('data-storage-key');

                if(localData.settings[storageKey]) {
                    agreedCount++;
                }

                modalSettingsCheckbox.checked = localData.settings[storageKey];
            }

            if(agreedCount === this.$modalSettingsCheckboxes.length) {
                for(const modalSettingsCheckAll of this.$modalSettingsCheckAll) {
                    modalSettingsCheckAll.checked = true;
                }
            }
        }
    }

    _checkVersion()
    {
        let localData = this._getLocalData();

        if(localData !== null && localData.version !== this.options.version) {
            localStorage.removeItem(this.options.storageKey);
        }
    }

    _events()
    {
        this.$bannerBtnAcceptAll.addEventListener('click', () => this.setSetting('*', true));
        this.$bannerBtnClose.addEventListener('click', () => this.setSetting('*', false));
        this.$bannerBtnSettings.addEventListener('click', () => this.openModal(this.$modalSettings));
        this.$modalSettings.addEventListener('click', e => this.closeModal(e));

        for(const modalSettingsCheckbox of this.$modalSettingsCheckboxes) {
            modalSettingsCheckbox.addEventListener('change', () => {
                this.setSetting(
                    modalSettingsCheckbox.getAttribute('data-storage-key'),
                    modalSettingsCheckbox.checked
                );
            });
        }

        for(const modalSettingsCheckAll of this.$modalSettingsCheckAll) {
            modalSettingsCheckAll.addEventListener('change', () => {
                this.setSetting('*', modalSettingsCheckAll.checked);

                for(const modalSettingsCheckAll2 of this.$modalSettingsCheckAll) {
                    modalSettingsCheckAll2.checked = modalSettingsCheckAll.checked;
                }
            });
        }

        this.$modalConfirm.addEventListener('click', e => this.closeModal(e));
        this.$modalConfirmBtnOnce.addEventListener('click', () => this._confirmationClick(false));
        this.$modalConfirmBtnAlways.addEventListener('click', () => this._confirmationClick(true));

        for(const modalClose of this.$modalClose) {
            modalClose.addEventListener('click', () => this.closeModal());
        }

        document.addEventListener('keyup', e => {
            if(e.key === 'Escape') {
                this.closeModal();
            }
        });

        this.$btnOpenSettings.addEventListener('click', () => this.openModal(this.$modalSettings));

        for(const collapseToggle of this.$collapseToggle) {
            collapseToggle.addEventListener('click', () => {
                let collapseTarget = document.getElementById(collapseToggle.getAttribute('data-collapse'));

                if(collapseTarget !== null) {
                    collapseTarget.classList.toggle(this.options.prefix + '-hidden');
                }
            });
        }
    }
}

$('.consent-show-more').on('click', function(e) {
    e.preventDefault();
});

$('#consent-accept-banner-btn-close').on('click', function(e) {
    $('[data-storage-key]').each(function(v,k){
        CM.setSetting($(k).data('storageKey'), $(k).is(':checked'));
    });

    CM.closeBanner();
});

$(document).ready(function() {
	if (typeof(window.CM) === 'undefined') {
		embedVideoServices({ youtube:true, vimeo:true });
	}
});
document.addEventListener('consent.ready', function(e) {
	embedVideoServices(e.detail);
});
document.addEventListener('consent.updated', function(e) {
	embedVideoServices(e.detail);
});

function embedVideoServices(detail) {
	if (detail !== null && typeof detail.youtube !== 'undefined' && detail.youtube === true) {
		let embeds = document.querySelectorAll('iframe.needs-consent.youtube');
		for (let i = 0; i < embeds.length; ++i) {
			embeds[i].src = embeds[i].dataset.src;
			embeds[i].className = 'youtube';
		}
		let notices = document.querySelectorAll('a[data-consent="youtube"]');
		for (let j = 0; j < notices.length; ++j) {
			notices[j].classList.add('d-none');
		}
	}
	if (detail !== null && typeof detail.vimeo !== 'undefined' && detail.vimeo === true) {
		let embeds = document.querySelectorAll('iframe.needs-consent.vimeo');
		for (let i = 0; i < embeds.length; ++i) {
			embeds[i].src = embeds[i].dataset.src;
			embeds[i].className = 'vimeo';
		}
		let notices = document.querySelectorAll('a[data-consent="vimeo"]');
		for (let j = 0; j < notices.length; ++j) {
			notices[j].classList.add('d-none');
		}
	}
}

function embedYoutube(detail) {
	embedVideoServices(detail);
}
