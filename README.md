# Orbital Propagators

This repository contains three distinct orbital propagation projects, each employing a different method for the task: Cowell's Method, Classical Orbital Parameters with J2 effect, and Battin Giorgi Propagation with constant perturbation acceleration. These projects demonstrate the application of various techniques in orbital mechanics for the prediction of future positions and velocities of celestial bodies.

## Projects

### 1. Cowell's Method (Universal gravitational law)

Cowell's method, named after British engineer and physicist Robert H. Cowell, involves numerically solving the two-body problem with the addition of perturbations. It uses Newton's Universal Law of Gravitation to derive the equations of motion and calculates future positions and velocities of celestial bodies based on their initial conditions.

#### Theory

Newton's Universal Law of Gravitation states that every point mass attracts every single other point mass by a force acting along the line intersecting both points. The force is proportional to the product of the two masses and inversely proportional to the square of the distance between them.

In Cowell's method, this law is used in combination with differential equations to model the motion of celestial bodies. The method can account for various perturbations such as atmospheric drag, solar radiation pressure, and non-uniform gravitational field of the celestial bodies.

### 2. Propagation of Classical Orbital Parameters with J2 Effect

This project involves the propagation of classical orbital elements: semi-major axis, eccentricity, inclination, longitude of the ascending node, argument of perigee, and true anomaly. In addition, it takes into account the effect of the Earth's equatorial bulge (J2 effect), which causes precession of the orbit.

#### Theory

The six classical orbital elements fully define an orbit. However, these elements are not constants of motion as they can change due to perturbations. The J2 effect, or the effect of the Earth's equatorial bulge, is one such perturbation. It causes a precession of the longitude of the ascending node and the argument of perigee, as well as a change in mean anomaly.

The effect of J2 is included in the equations of motion and integrated over time to provide the evolution of the classical orbital elements.

### 3. Battin Giorgi Propagation with Constant Perturbation Acceleration

This project uses the Battin Giorgi Propagation method, which is particularly effective for short-term propagation and includes a constant perturbation acceleration.

#### Theory

Battin Giorgi Propagation method employs a special set of orbital elements, called universal variables, to solve the Kepler problem more efficiently. This method uses the technique of variation of parameters and the universal anomaly to write a set of differential equations which describe the motion of the body under the central gravitational force and a perturbation acceleration.

This method is well-suited for cases with small perturbations as it allows the inclusion of a constant perturbation acceleration in the equations of motion. It provides an efficient and accurate way of propagating orbits.

---

## Disclaimer

These projects are created for educational purposes. Please use responsibly and ensure all simulations and data are used in a manner adhering to applicable laws and regulations.

