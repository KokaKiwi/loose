<loose>
    <div id="main" class="container">
        <div class="columns blankslate">
            <h1 class="title">Loose</h1>

            <form>
                <div>
                    <label for="seed">Seed</label>
                    <input type="text" class="input-block" name="seed" placeholder="Seed" onkeyup={ updateState } onfocus={ onFocus } onblur={ onBlur } /><br />
                </div>

                <div if={ showTitle }>
                    <label for="title">Title</label>
                    <input type="text" class="input-block" name="title" placeholder="Title" onkeyup={ updateState } onfocus={ onFocus } onblur={ onBlur } />
                </div>
            </form>

            <br />
            <div class="flash" if={ showPassword }>
                <h3>
                    Password: <b>{ password.value }</b><br /><br />
                    <input type="text" class="input-large" name="password" />
                </h3>
            </div>
        </div>
    </div>

    <script>
        this.loose = new Loose(this);

        updateState() {
            this.loose.updateState();
        }

        onFocus(e) {
            this.loose.updateFocus(e.target, true);
        }

        var self = this;

        var mt;

        var config = {
            password: {
                alphabet: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.',
                length: 8,
            },
            seeder: function() {
                return self.seed.value + '//' + self.title.value;
            },
        };

        var randomString = function() {
            var str = '';
            while (str.length < config.password.length) {
                var index = mt() % config.password.alphabet.length;
                str += config.password.alphabet.charAt(index);
            }
            return str;
        };

        var generate = function() {
            mt = Random.engines.mt19937()
            mt.seedWithArray(config.seeder());

            return randomString();
        };

        var updateFocus = function(target, state) {
            var passwordMode = target != self.seed || !state;

            self.seed.type = passwordMode ? 'password' : 'text';
        };

        updateState() {
            this.showTitle = this.seed.value != undefined && this.seed.value != '';
            this.showPassword = this.showTitle && this.title.value != undefined && this.title.value != '';

            if (this.showPassword) {
                this.password.value = generate();
            }
        }

        onFocus(e) {
            updateFocus(e.target, true);
        }
        onBlur(e) {
            updateFocus(e.target, false);
        }

        self.updateState();
    </script>
</loose>
