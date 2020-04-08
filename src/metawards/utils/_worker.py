
from .._network import Network
from .._parameters import Parameters

import os
import sys
from contextlib import contextmanager

__all__ = ["run_worker", "prepare_worker"]

global_network = None


@contextmanager
def silence_output():
    """Nice way to silence stdout and stderr - thanks to
       Emil Stenström in
       https://stackoverflow.com/questions/6735917/redirecting-stdout-to-nothing-in-python
    """
    new_out = open(os.devnull, "w")
    old_out = sys.stdout
    sys.stdout = new_out

    new_err = open(os.devnull, "w")
    old_err = sys.stderr
    sys.stderr = new_err

    try:
        yield new_out
    finally:
        sys.stdout = old_out
        sys.stderr = old_err


def prepare_worker(params: Parameters):
    """Prepare a worker to receive work to run a model using the passed
       parameters. This will build the network specified by the
       parameters and will store it in global memory ready to
       be used for a model run. Note that these are
       silent, printing nothing to stdout or stderr
    """
    # switch off printing to stdout and stderr
    with silence_output():
        global global_network

        if global_network is None:
            global_network = Network.build(params=params,
                                           calculate_distances=True,
                                           profile=False)

        else:
            global_network.update(params)


def run_worker(arguments):
    """Ask the worker to run a model using the passed variables and
       options. This will write to options['output_dir'] and will
       also return the population object that contains the final
       population data
    """
    params = arguments["params"]
    options = arguments["options"]

    # first, build and prepare the network
    prepare_worker(params)

    # next, run the job, writing to output
    from ._runner import redirect_output

    outdir = options["output_dir"]

    if not os.path.exists(outdir):
        os.mkdir(outdir)

    with redirect_output(outdir):
        global global_network
        output = global_network.run(**options)

        return output
