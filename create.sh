
#!/bin/bash

# -------------------------------
# Project Setup
# -------------------------------
PROJECT_NAME="mpjs-mapbox3d"
NODE_VERSION=$(node -v)
echo "🟢 Setting up $PROJECT_NAME (Node $NODE_VERSION)"

# Create project directories
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME || exit
mkdir -p src/components/core
mkdir -p src/components/pro
mkdir -p docs

# -------------------------------
# package.json
# -------------------------------
cat <<EOL > package.json
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.1",
    "vite": "^5.4.8"
  },
  "engines": {
    "node": ">=22"
  }
}
EOL

# -------------------------------
# vite.config.js
# -------------------------------
cat <<EOL > vite.config.js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: { port: 5173, open: true },
  build: { outDir: "dist" }
});
EOL

# -------------------------------
# index.html
# -------------------------------
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Treweler Features Showcase</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOL

# -------------------------------
# Feature Arrays
# -------------------------------
CORE_FEATURES=(
"IntegratedMapbox"
"MultipleMaps"
"ShortcodeEmbed"
"MapStyles"
"TerrainBuildings3D"
"PresetStyles"
"LayerToggle"
"InitialView"
"MapControls"
"DistanceScale"
"MapBranding"
"CustomPreloader"
"LanguageSwitcher"
"MarkersPopups"
"Routes"
)

PRO_FEATURES=(
"GeoJSONLocator"
"RouteLocator"
"ModelLocator3D"
"ShapeRegionLocator"
"ExportGPX"
"FixedPopups"
"MassMarkers"
"DynamicPermalinks"
"CategoryStyles"
"SearchMarker"
"SearchArea"
"DirectMarkerLink"
"StoreLocatorPanel"
"Filters"
"ShapesTools"
"MarkerTemplateBuilder"
"CustomFields"
"MarkerGallery"
"Boundaries"
"MapProjections"
)

# -------------------------------
# Create JSX Component Function
# -------------------------------
create_component() {
    local DIR=$1
    local NAME=$2
    local DESC=$3

    FILE="$DIR/$NAME.jsx"
    if [ ! -f "$FILE" ]; then
        cat <<EOL > "$FILE"
export default function $NAME() {
  return (
    <section style={{ border: "1px solid #ccc", padding: "1rem", margin: "1rem 0", borderRadius: "8px" }}>
      <h3>$NAME</h3>
      <p>$DESC</p>
    </section>
  );
}
EOL
    fi
}

# -------------------------------
# Create Core Components + index.js
# -------------------------------
CORE_DIR="src/components/core"
for f in "${CORE_FEATURES[@]}"; do
    create_component "$CORE_DIR" "$f" "This is the core feature: $f."
done

CORE_INDEX="$CORE_DIR/index.js"
echo "// Auto-generated index for Core features" > $CORE_INDEX
for f in "${CORE_FEATURES[@]}"; do
    echo "export { default as $f } from './$f';" >> $CORE_INDEX
done

# -------------------------------
# Create Pro Components + index.js
# -------------------------------
PRO_DIR="src/components/pro"
for f in "${PRO_FEATURES[@]}"; do
    create_component "$PRO_DIR" "$f" "This is the pro/premium feature: $f."
done

PRO_INDEX="$PRO_DIR/index.js"
echo "// Auto-generated index for Pro features" > $PRO_INDEX
for f in "${PRO_FEATURES[@]}"; do
    echo "export { default as $f } from './$f';" >> $PRO_INDEX
done

# -------------------------------
# FeatureWrapper.jsx
# -------------------------------
WRAPPER_FILE="src/components/FeatureWrapper.jsx"
cat <<EOL > "$WRAPPER_FILE"
export default function FeatureWrapper({ children }) {
  return (
    <div style={{ margin: "1rem 0", padding: "1rem", border: "1px solid #888", borderRadius: "8px", background: "#f9f9f9" }}>
      {children}
    </div>
  );
}
EOL

# -------------------------------
# App.jsx
# -------------------------------
APP_FILE="src/App.jsx"
cat <<EOL > "$APP_FILE"
import React from "react";
import FeatureWrapper from "./components/FeatureWrapper";
import * as CoreFeatures from "./components/core";
import * as ProFeatures from "./components/pro";

export default function App() {
  return (
    <main style={{ fontFamily: "sans-serif", padding: "2rem" }}>
      <h1>🌍 Treweler Features Showcase</h1>

      <section>
        <h2>Core Features</h2>
        {Object.entries(CoreFeatures).map(([name, Component]) => (
          <FeatureWrapper key={name}>
            <Component />
          </FeatureWrapper>
        ))}
      </section>

      <hr style={{ margin: "2rem 0" }} />

      <section>
        <h2>Pro / Premium Features</h2>
        {Object.entries(ProFeatures).map(([name, Component]) => (
          <FeatureWrapper key={name}>
            <Component />
          </FeatureWrapper>
        ))}
      </section>
    </main>
  );
}
EOL

# -------------------------------
# main.jsx
# -------------------------------
MAIN_FILE="src/main.jsx"
cat <<EOL > "$MAIN_FILE"
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOL

# -------------------------------
# FEATURES.md
# -------------------------------
FEATURES_MD="docs/FEATURES.md"
cat <<EOL > "$FEATURES_MD"
# 📌 Treweler Features

## Core Features
- Fully integrated with WordPress & Mapbox
- Create & manage multiple maps
- Embed maps anywhere using shortcodes
- Pre-installed map styles and custom Mapbox Studio styles
- 3D terrain & 3D buildings
- Light presets for Day, Dusk, Dawn, Night
- Toggle map layers (classic & custom)
- Set initial center & zoom level
- Display map controls: zoom, pan, search, geolocation, fullscreen, distance scale
- Distance scale in metric, imperial, nautical
- Title, description, logo for maps
- Custom preloader with logo/text
- Change map language
- Marker & popup support with customizable styles
- Routes: draw and customize with color, width, opacity, dash/gap

## Pro / Premium Features
- GeoJSON Region Locator: connect GeoJSON files
- Route Locator: connect GPX or drawn routes
- 3D Model Locator for markers
- Shape Region Locator: regions + shapes
- Export routes to GPX
- Fixed popup positions
- Mass Marker Maps: handle large marker sets
- Dynamic Permalinks: share map view state
- Category-based marker styles
- Search by marker name or within visible area
- Direct marker links
- Store Locator Panels & extended filters
- Shapes & Drawing Tools: polygons, circles, curves
- Marker Template Builder
- Custom Fields Builder (text, link, email, phone, HTML)
- Marker Image Gallery
- Countries & Regions Boundaries
- Alternative Map Projections (Globe, Equal Earth, Lambert, etc.)
EOL

echo "✅ Full project + docs created!"
echo "Run 'npm install' and 'npm run dev' to start your app."