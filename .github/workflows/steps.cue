// Steps specific to the project
package actions

// Versions for simplicity
_versions: {
	// The versions here have an underlying Debian/Ubuntu which support enough of
	// libsodium to handle what enacl provides. Older versions will fail to compile
	otp: ["22.3", "23.3", "24.0"]
	rebar3: "3.16.1"
}

// What branch are we interested in?
_branch: "master"

// Job steps
jobs: ci: steps:
[
	{
		uses: "actions/checkout@v2"
	},
	{
		uses: "erlef/setup-beam@v1"
		with: {
			"otp-version":    "${{matrix.otp_vsn}}"
			"rebar3-version": _versions.rebar3
		}
	},
	{
		name: "Compile source code"
		run:  "rebar3 compile"
	},
	{
		name: "Run the tests"
		run:  "rebar3 ct"
	},
]
