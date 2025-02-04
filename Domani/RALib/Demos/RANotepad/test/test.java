package symantec.itools.awt.shape;

import java.awt.Graphics;
import java.awt.Polygon;
import java.awt.Dimension;
import java.beans.PropertyVetoException;
import java.beans.PropertyChangeListener;
import java.beans.VetoableChangeListener;

//  07/31/97	LAB	Created, implemented and checked in.
//  08/13/97	LAB	Added getPreferredSize which returns a 50 by 50 dimension and getMinimumSize
//				which returns a 10 by 10 dimension, just like the Shape class. Addresses Mac
//				Bug #7138.  Changed the default slope to negative.  Addresses Mac Bug #7193
//  08/29/97    CAR modified getPreferredSize

/**
 * Implements a line than can have a thickness.
 * @version 1.1, July 30, 1997
 * @author Symantec
 */
public class Line extends java.awt.Component
{
    /**
     * Constructs a default Line with positive slope and thickness of 1 pixel.
     */
    public Line()
    {
    	slopeType		= false;
    	lineThickness	= 1;
    }

	/**
	 * Sets the slope type of the line to draw.
	 * @param type if the type is true the line will be drawn from
	 * the lowwer left corner to the upper right corner.  If the type is false,
	 * the line will be drawn from the upper left corner to the bottom right corner.
     * @exception PropertyVetoException
     * if the specified property value is unacceptable
	 * @see #isPositiveSlope
	 */
	public void setPositiveSlope(boolean type) throws PropertyVetoException
	{
		if (slopeType != type)
		{
			Boolean oldValue = new Boolean(slopeType);
			Boolean newValue = new Boolean(type);

			vetos.fireVetoableChange("PositiveSlope", oldValue, newValue);

	        slopeType = type;
	        repaint();

			changes.firePropertyChange("PositiveSlope", oldValue, newValue);
		}
	}

	/**
	 * Gets the slope type of the line to draw.
	 * @return true if the line will be drawn from the lowwer left corner to the
	 * upper right corner.  false if the line will be drawn from the upper left
	 * corner to the bottom right corner.
	 * @see #setPositiveSlope
	 */
	public boolean isPositiveSlope()
	{
		return slopeType;
	}

	/**
	 * Sets the thikcness of the line to draw.
	 * @param thickness the thickness of the line in pixels
     * @exception PropertyVetoException
     * if the specified property value is unacceptable
	 * @see #getLineThickness
	 */
	public void setLineThickness(int thickness) throws PropertyVetoException
	{
		if (lineThickness != thickness)
		{
			Integer oldValue = new Integer(lineThickness);
			Integer newValue = new Integer(thickness);

			vetos.fireVetoableChange("LineThickness", oldValue, newValue);

	        lineThickness = thickness;
	        repaint();

			changes.firePropertyChange("LineThickness", oldValue, newValue);
		}
	}

	/**
	 * Gets the thickness of the line to draw.
	 * @return the thickness of the line in pixels
	 * @see #setLineThickness
	 */
	public int getLineThickness()
	{
		return lineThickness;
	}

    /**
	 * Returns the minimum dimensions to properly display this component.
     * This is a standard Java AWT method which gets called to determine
     * the minimum size of this component.
     * Returns the results of a call to getPreferredSize.
     * @see #getPreferredSize
	 */
    public Dimension getMinimumSize()
    {
    	return new Dimension(10, 10);
    }

    /**
	 * Returns the recommended dimensions to properly display this component.
     * This is a standard Java AWT method which gets called to determine
     * the recommended size of this component.
     *
     * @return horiziontal and vertical dimensions of 50, 50
     *
     * @see java.awt.Component#minimumSize
	 */
    public Dimension getPreferredSize()
    {
        Dimension dim = size();
        Dimension min = getMinimumSize();

        return new Dimension(Math.max(dim.width, min.width), Math.max(dim.height, min.height));
    }

    /**
     * Adds a listener for all property change events.
     * @param listener the listener to add
     * @see #removePropertyChangeListener
     */
    public synchronized void addPropertyChangeListener(PropertyChangeListener listener)
    {
    	changes.addPropertyChangeListener(listener);
    }

    /**
     * Removes a listener for all property change events.
     * @param listener the listener to remove
     * @see #addPropertyChangeListener
     */
    public synchronized void removePropertyChangeListener(PropertyChangeListener listener)
    {
    	changes.removePropertyChangeListener(listener);
    }

    /**
     * Adds a listener for all vetoable property change events.
     * @param listener the listener to add
     * @see #removeVetoableChangeListener
     */
    public synchronized void addVetoableChangeListener(VetoableChangeListener listener)
    {
		vetos.addVetoableChangeListener(listener);
    }

    /**
     * Removes a listener for all vetoable property change events.
     * @param listener the listener to remove
     * @see #addVetoableChangeListener
     */
    public synchronized void removeVetoableChangeListener(VetoableChangeListener listener)
    {
    	vetos.removeVetoableChangeListener(listener);
    }

    /**
     * Checks whether this component "contains" the specified (x, y)
     * location, where x and y are defined to be relative to the
     * coordinate system of this component.
     * @param x the x coordinate
     * @param y the y coordinate
     * @see java.awt.Component#getComponentAt
     */
    public boolean contains(int x, int y)
    {
    	if(!super.contains(x, y))
    		return false;

    	if (lineThickness > 1)
    	{
    		if (poly != null)
    			return poly.contains(x, y);
    		else
    			return false;
    	}
    	else
    	{
	    	double x1, y1, x2, y2, i = 0;
	    	double calc;

	        Dimension s = getSize();

	        if(slopeType)
	        {
	        	x1 = s.width;
	        	y1 = 0;
	        	x2 = 0;
	        	y2 = s.height;
	        }
	        else
	        {
			    x1 = s.width;
			    y1 = s.height;
			    x2 = 0;
			    y2 = 0;
			}

			if(s.width > s.height)
			{
				calc = Math.abs( (((y1 - y2) * (x - x2)) / (x1 - x2)) + y2 );
				if (Math.abs(y - calc) < 0.7)
					return true;
				else
					return false;
			}
			else
			{
				calc = Math.abs( (((x1 - x2) * (y - y2)) / (y1 - y2)) + x2 );
				if (Math.abs(x - calc) < 0.7)
					return true;
				else
					return false;
			}
    	}
    }

	/**
	 * Paints the line using the given graphics context.
     * This is a standard Java AWT method which typically gets called
     * by the AWT to handle painting this component. It paints this component
     * using the given graphics context. The graphics context clipping region
     * is set to the bounding rectangle of this component and its <0,0>
     * coordinate is this component's top-left corner.
     *
     * @param g the graphics context used for painting
     * @see java.awt.Component#repaint
     * @see java.awt.Component#update
	 */
    public void paint(Graphics g)
    {
    	int x1, y1, x2, y2, i = 0;

        Dimension s = getSize();

        if(slopeType)
        {
        	x1 = s.width;
        	y1 = 0;
        	x2 = 0;
        	y2 = s.height;
        }
        else
        {
	        x1 = s.width;
	        y1 = s.height;
	        x2 = 0;
	        y2 = 0;
		}

        g.setColor(getForeground());
		if(lineThickness > 1)
		{
			double w		= lineThickness/2;
			double theta	= 3.1416 - (1.5708 + Math.abs(Math.atan((double)(y1 - y2)/(x1 - x2))));
			double a		= Math.abs(w * Math.cos(theta));
			double b		= Math.abs(w * Math.sin(theta));
			int A1x, B1y, A2x, B2y;

			if(slopeType)
			{
				A1x = (int) (x1 - a - a);
				B1y = (int) (y1 + b + b);

				A2x = (int) (x2 + a + a);
				B2y = (int) (y2 - b - b);
			}
			else
			{
				A1x = (int) (x1 - a - a);
				B1y = (int) (y1 - b - b);

				A2x = (int) (x2 + a + a);
				B2y = (int) (y2 + b + b);
			}
			poly = new Polygon();
			poly.addPoint(A1x, (int) y1);
			poly.addPoint((int) x1, B1y);
			poly.addPoint(A2x, (int) y2);
			poly.addPoint((int) x2, B2y);
			g.fillPolygon(poly);
		}
		else
		{
	        g.drawLine(x1, y1, x2, y2);
		}
    }

	/**
	 * The slope type of the line to be drawn (either positive (true) or negative (false)).
	 */
	protected boolean slopeType;

	/**
	 * The thickness of the line to draw.
	 */
	 protected int lineThickness;

	/**
	 * The polygon that defines the line when lineThickness is larger than 1.
	 */
	protected Polygon poly = null;

	private symantec.itools.beans.VetoableChangeSupport vetos = new symantec.itools.beans.VetoableChangeSupport(this);
    private symantec.itools.beans.PropertyChangeSupport changes = new symantec.itools.beans.PropertyChangeSupport(this);
}

