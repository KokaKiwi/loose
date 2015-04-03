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

        this.loose.updateState();
    </script>
</loose>
