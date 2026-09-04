"""Le Mans Ultimate"""

from protonfixes import util


def main() -> None:
    """Use builtin d3dx11_43 for the patched CUR loader"""
    util.winedll_override('d3dx11_43', util.OverrideOrder.BUILTIN)
