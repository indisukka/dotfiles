package main

import (
	"encoding/binary"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"os/exec"
)

var mpvCmd = []string{"mpv", "--player-operation-mode=pseudo-gui", "--"}

type ffRequest struct {
	URL string `json:"url"`
}

type ffManifest struct {
	Name              string   `json:"name"`
	Description       string   `json:"description"`
	Path              string   `json:"path"`
	Type              string   `json:"type"`
	AllowedExtensions []string `json:"allowed_extensions"`
}

func ff2mpv() {
	// extract message length from the first 4 bytes
	var l uint32
	// Go does not have an easy way to do sutff with native endianness without
	// using unsafe. Blame the stupid WebExtension spec that uses *native*
	// endianness in a *protocol*. Seriously, who designed that‽
	if err := binary.Read(os.Stdin, endianness, &l); err != nil {
		panic(err)
	}
	if l > 1024*1024 {
		panic(fmt.Sprintf("native messaging message length too large: %d", l))
	}

	// read raw message
	buf := make([]byte, l)
	if n, err := os.Stdin.Read(buf); err != nil {
		panic(err)
	} else if n != len(buf) {
		panic(fmt.Sprintf("read message length %d does not match expected length %d", n, l))
	}

	// decode JSON
	var data ffRequest
	if err := json.Unmarshal(buf, &data); err != nil {
		panic(err)
	}

	// run mpv
	args := append(mpvCmd, data.URL)
	cmd := exec.Command(args[0], args[1:]...)
	if err := cmd.Start(); err != nil {
		panic(err)
	}

	// respond
	outmsg := []byte("{}")
	outlen := uint32(len(outmsg))
	binary.Write(os.Stdout, endianness, outlen)
	os.Stdout.Write(outmsg)
}

func manifest() {
	exe, err := os.Executable()
	if err != nil {
		panic(err)
	}
	data, err := json.MarshalIndent(ffManifest{
		Name:              "ff2mpv",
		Description:       "ff2mpv's extenal manifest (ff2mpv-go)",
		Path:              exe,
		Type:              "stdio",
		AllowedExtensions: []string{"ff2mpv@yossarian.net"},
	}, "", "\t")
	if err != nil {
		panic(err)
	}
	os.Stdout.Write(data)
}

func usage(w io.Writer) {
	fmt.Fprintf(w, "usage: %s [--manifest]\n", os.Args[0])
}

func main() {
	arg := ""
	if len(os.Args) == 2 {
		arg = os.Args[1]
	}
	switch arg {
	case "--manifest":
		manifest()
	case "--help":
		usage(os.Stdout)
	default:
		ff2mpv()
	}
}
