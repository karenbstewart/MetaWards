
from .._network import Network
from .._parameters import Parameters
from .._population import Population

from ._profiler import Profiler, NullProfiler

from ..iterators._advance_play import advance_play_omp
from ..iterators._advance_fixed import advance_fixed_omp
from ..iterators._advance_infprob import advance_infprob_omp
from ..iterators._advance_recovery import advance_recovery_omp
from ..iterators._advance_foi import advance_foi_omp
from ..iterators._advance_imports import advance_imports_omp

from ..iterators import iterate_default

__all__ = ["iterate"]


def iterate(network: Network, population: Population,
            infections, play_infections,
            rngs, nthreads: int,
            get_advance_functions=iterate_default,
            profiler: Profiler=None):
    """Advance the infection by one day for the passed Network,
       acting on the passed Population.

       Parameters
       ----------
       network: Network
         The network in which the disease outbreak will be modelled
       population: Population
         The population experiencing the outbreak. This contains
         an overview of the current population, plus the day and
         date of the outbreak
       infections
         Space in which the 'work' (fixed) infections are recorded
       play_infections
         Space in which the 'play' (random) infections are recorded
       rngs
         List of the thread-safe random number generators (one per thread)
       nthreads: int
         The number of threads over which to parallelise the calculation
       get_advance_functions: function
         This is a function that should return the set of "advance_XXX"
         functions that will be applied as part of this iteration
       profiler: Profiler
         The profiler to use to profile this calculation. Pass "None"
         if you want to disable profiling
    """
    if profiler is None:
        profiler = NullProfiler()

    p = profiler.start("iterate")

    #advance_functions = get_advance_functions(population=population,
    #                                          nthreads=nthreads)

    advance_imports_omp(network=network,
                        population=population,
                        infections=infections,
                        play_infections=play_infections,
                        rngs=rngs, nthreads=nthreads,
                        profiler=p)

    advance_foi_omp(network=network,
                    population=population,
                    infections=infections,
                    play_infections=play_infections,
                    rngs=rngs, nthreads=nthreads,
                    profiler=p)

    advance_recovery_omp(network=network,
                         population=population,
                         infections=infections,
                         play_infections=play_infections,
                         rngs=rngs, nthreads=nthreads,
                         profiler=p)

    advance_infprob_omp(network=network,
                        population=population,
                        infections=infections,
                        play_infections=play_infections,
                        rngs=rngs, nthreads=nthreads,
                        profiler=p)

    advance_fixed_omp(network=network,
                      population=population,
                      infections=infections,
                      play_infections=play_infections,
                      rngs=rngs, nthreads=nthreads,
                      profiler=p)

    advance_play_omp(network=network,
                     population=population,
                     infections=infections,
                     play_infections=play_infections,
                     rngs=rngs, nthreads=nthreads,
                     profiler=p)

    p.stop()
